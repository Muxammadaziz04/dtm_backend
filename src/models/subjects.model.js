const { fetchData } = require('../utils/postgres.js')

const getFirstSubjectModel = async () => {
    try {
        const getFirstSubjectQuery = `
        select s.* from faculties as f left join subjects as s on s.subject_id = f.first_subject group by s.subject_id
        `
        return await fetchData(getFirstSubjectQuery)
    } catch (error) {
        console.log(error);
    }
}

const getSecondSubjectModel = async ({ first_subject_id }) => {
    try {
        const getSecondSubjectQuery = `
        select s.* from faculties as f left join subjects as s on s.subject_id = f.second_subject where f.first_subject = $1 group by s.subject_id 
        `
        return await fetchData(getSecondSubjectQuery, first_subject_id)
    } catch (error) {
        console.log(error);
    }
}

const postSubjectModel = async ({ subject_name }) => {
    try {
        const postSubjectQuery = `
        insert into subjects(subject_name)
        values ($1) returning *
        `
        return await fetchData(postSubjectQuery, subject_name)
    } catch (error) {
        console.log(error);
    }
}

const putSubjectModel = async ({ subject_name }, { subject_id }) => {
    try {
        const getFacultiesQuery = `
        update subjects set subject_name = $2 where subject_id = $1
        `
        return await fetchData(getFacultiesQuery, subject_id, subject_name)
    } catch (error) {
        console.log(error);
    }
}

const deleteSubjectModel = async ({ subject_id }) => {
    try {
        const deletSubjectQuery = `
        delete from subjects where subject_id = $1
        `
        return await fetchData(deletSubjectQuery, subject_id)
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    getFirstSubjectModel,
    getSecondSubjectModel,
    postSubjectModel,
    putSubjectModel,
    deleteSubjectModel
}