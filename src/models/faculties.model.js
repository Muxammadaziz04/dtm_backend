const { fetchData } = require('../utils/postgres.js')

const getFacultiesModel = async ({ faculty_id }) => {
    try {
        const getFacultiesQuery = `
        select 
            f.*, 
            (select region_name from regions where region_id = (select region_id from universities where university_id = f.university_id)) 
        from faculties as f where faculty_id = $1
        `
        return await fetchData(getFacultiesQuery, faculty_id)
    } catch (error) {
        console.log(error);
    }
}

const postFacultyModel = async ({ faculty_name, first_subject, second_subject, grant_count, contract_count, passing_score_grant, passing_scire_contract, university_id }) => {
    try {
        const postFacultyQuery = `
        insert into faculties(faculty_name, first_subject, second_subject, grant_count, contract_count, passing_score_grant, passing_scire_contract, university_id)
        values ($1,$2,$3,$4,$5,$6,$7,$8) returning *
        `
        return await fetchData(postFacultyQuery, faculty_name, first_subject, second_subject, grant_count, contract_count, passing_score_grant, passing_scire_contract, university_id)
    } catch (error) {
        console.log(error);
    }
}

const putFacultyModel = async (body, { faculty_id }) => {
    try {
        const getFacultyQuery = `select * from foods where food_id = $1`
        const [oldFaculty] = await fetchData(getFacultyQuery, faculty_id)

        if (!oldFaculty) return []

        const { 
            faculty_name, 
            first_subject, 
            second_subject, 
            grant_count, 
            contract_count, 
            passing_score_grant, 
            passing_scire_contract, 
            university_id 
        } = { ...oldFaculty, ...body }

        const putFacultyQuery = `
        update faculties set 
        faculty_name = $2, 
        first_subject = $3, 
        second_subject = $4, 
        grant_count = $5, 
        contract_count = $6, 
        passing_score_grant = $7, 
        passing_scire_contract = $8, 
        university_id = $9
        where faculty_id = $1
        `
        return await fetchData(putFacultyQuery, faculty_id, faculty_name, first_subject, second_subject, grant_count, contract_count, passing_score_grant, passing_scire_contract, university_id)
    } catch (error) {
        console.log(error);
    }
}

const deleteFacultyModel = async ({ faculty_id }) => {
    try {
        const deleteFacultysQuery = `
        delete from faculties where faculty_id = $1
        `
        return await fetchData(deleteFacultysQuery, faculty_id)
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    getFacultiesModel,
    postFacultyModel,
    putFacultyModel,
    deleteFacultyModel
}