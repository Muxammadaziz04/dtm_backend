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
module.exports = {
    getFacultiesModel
}