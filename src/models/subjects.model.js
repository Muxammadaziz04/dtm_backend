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

module.exports = {
    getFirstSubjectModel,
    getSecondSubjectModel
}