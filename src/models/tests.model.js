const { fetchData } = require('../utils/postgres.js')

const getTestsModel = async ({ first_subject, second_subject }) => {
    try {
        const getTestsQuery = `
        (
            select s.*, json_agg(q.* order by random()) as tests from subjects as s 
            left join questions as q on s.subject_id = q.subject_id 
            where q.subject_id = $1 group by s.subject_id
        )
        union all
        (
            select s.*, json_agg(q.* order by random()) as tests from subjects as s 
            left join questions as q on s.subject_id = q.subject_id 
            where q.subject_id = $2 group by s.subject_id
        )
        `
        return await fetchData(getTestsQuery, first_subject, second_subject)
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    getTestsModel
}