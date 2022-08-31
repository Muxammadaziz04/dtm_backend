const { fetchData } = require('../utils/postgres.js')

const getRegionsModel = async () => {
    try {
        const getRegionsQuery = `
        select * from regions
        `
        return await fetchData(getRegionsQuery)
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    getRegionsModel
}