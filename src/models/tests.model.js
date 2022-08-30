const { fetchData } = require('../utils/postgres.js')

const getTestsModel = async ({ first_subject, second_subject }) => {
    try {
        const getTestsQuery = `
        (select * from questions where subject_id = $1 order by random() limit 30)
        union all
        (select * from questions where subject_id = $2 order by random() limit 30)
        `
        return await fetchData(getTestsQuery, first_subject, second_subject)
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    getTestsModel
}