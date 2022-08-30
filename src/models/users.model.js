const { fetchData } = require('../utils/postgres.js')

const loginModel = async ({ contact, password }) => {
    try {
        const loginQuery = `
        select * from users where contact = $1 and password = $2
        `
        return await fetchData(loginQuery, contact, password)
    } catch (error) {
        console.log(error);
    }
}

const registerModel = async ({ fullname, contact, region_id, password, gender }) => {
    try {
        const registerQuery = `
        insert into users(fullname, contact, region_id, password, gender) values ($1, $2, $3, $4, $5) returning *
        `
        return await fetchData(registerQuery, fullname, contact, region_id, password, gender)
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    loginModel,
    registerModel
}