const { fetchData } = require('../utils/postgres.js')

const getFacultiesModel = async ({ faculty_id }) => {
    try {
        const getFacultiesQuery = `
        select * from faculties where faculty_id = $1
        `
        return await fetchData(getFacultiesQuery, faculty_id)
    } catch (error) {
        console.log(error);
    }
}
module.exports = {
    getFacultiesModel
}