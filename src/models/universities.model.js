const { fetchData } = require('../utils/postgres.js')

const getUniversitiesModel = async ({ first_subject, second_subject }) => {
    try {
        const getFirstSubjectQuery = `
        select u.*, json_agg(f.*) as faculties from faculties as f left join universities as u 
            on u.university_id = f.university_id 
            where f.first_subject = $1 and f.second_subject = $2 
        group by u.university_id
        `
        return await fetchData(getFirstSubjectQuery, first_subject, second_subject)
    } catch (error) {
        console.log(error);
    }
}

const postUniversityModel = async ({ university_name, region_id }) => {
    try {
        const postUniversityQuery = `
        insert into universities(university_name, region_id)
        values ($1, $2) returning *
        `
        return await fetchData(postUniversityQuery, university_name, region_id)
    } catch (error) {
        console.log(error);
    }
}

const putUniversityModel = async (body, { university_id }) => {
    try {
        const getUniversityQuery = `select * from universities where university_id = $1`
        const [oldUniversity] = await fetchData(getUniversityQuery, university_id)

        if (!oldUniversity) return []

        const { university_name, region_id } = { ...oldUniversity, ...body }

        const putFacultyQuery = `
        update universities set 
        university_name = $2,
        region_id = $3
        where university_id = $1 returning *
        `
        return await fetchData(putFacultyQuery, university_id, university_name, region_id)
    } catch (error) {
        console.log(error);
    }
}

const deleteUniversityModel = async ({ university_id }) => {
    try {
        const deletUniversityQuery = `
        delete from universities where university_id = $1 returning *
        `
        return await fetchData(deletUniversityQuery, university_id)
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    getUniversitiesModel,
    postUniversityModel,
    putUniversityModel,
    deleteUniversityModel
}