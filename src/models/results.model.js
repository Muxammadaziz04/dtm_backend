const { fetchData } = require('../utils/postgres.js')

const postResultsModel = async ({ first_subject, second_subject, first_tests_count, second_tests_count, faculties, time, first_subject_id, second_subject_id }, user_id) => {
    try {
        const postResultsQuery = `
        insert into results(first_subject, second_subject, score_ball, time, user_id, faculty_id, first_tests_count, second_tests_count, first_subject_id,second_subject_id) values
        ($1, $2, (3.1 * $1::int + 2.1 * $2::int), $3, $4, 
        (
            select faculty_id from faculties 
            where array[faculty_id::text] <@ $5 and (3.1 * $1::int + 2.1 * $2::int) >= passing_score_contract
            order by array_position($5, faculty_id::text) limit 1
        ), $6, $7, $8, $9) 
        returning *
        `
        return await fetchData(postResultsQuery, first_subject, second_subject, time, user_id, faculties, first_tests_count, second_tests_count, first_subject_id, second_subject_id)
    } catch (error) {
        console.log(error);
    }
}

const getResultsByIdModel = async ({ result_id }) => {
    try {
        const getResultsByIdQuery = `
        select 
            r.*,
            (select university_name from universities where university_id = (select university_id from faculties where faculty_id = r.faculty_id)),
            (select faculty_name from faculties where faculty_id = r.faculty_id),
            (select subject_name from subjects where subject_id = r.first_subject_id) as first_subject_name,
            (select subject_name from subjects where subject_id = r.second_subject_id) as second_subject_name,
            (select 
                case
                    when passing_score_grant >= r.score_ball then 'Davlat granti' 
                    else 'Shartnoma asosida'    
                end
            from faculties where faculty_id = r.faculty_id
            ) as type_of_training
        from results as r where r.result_id = $1
        `
        return await fetchData(getResultsByIdQuery, result_id)
    } catch (error) {
        console.log(error);
    }
}

const getResultsModel = async (user_id) => {
    try {
        const getResultsQuery = `
        select 
            r.*,
            (select university_name from universities where university_id = (select university_id from faculties where faculty_id = r.faculty_id)),
            (select faculty_name from faculties where faculty_id = r.faculty_id),
            (select 
                case
                    when passing_score_grant >= r.score_ball then 'Davlat granti' 
                    else 'Shartnoma asosida'  
                end
            from faculties where faculty_id = r.faculty_id
            ) as type_of_training
        from results as r where r.user_id = $1
        `
        return await fetchData(getResultsQuery, user_id)
    } catch (error) {
        console.log(error);
    }
}

const getHighestResultsModel= async () => {
    try {
        const getHighestResultsQuery = `
        select 
            r.*,
            (select faculty_name from faculties where faculty_id = r.faculty_id),
            (select fullname from users where user_id = r.user_id),
            (select 
                case
                    when passing_score_grant >= r.score_ball then 'Davlat granti' 
                    else 'Shartnoma asosida'  
                end
            from faculties where faculty_id = r.faculty_id
            ) as type_of_training
        from results as r order by r.score_ball desc
        `
        return await fetchData(getHighestResultsQuery)
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    postResultsModel,
    getResultsModel,
    getResultsByIdModel,
    getHighestResultsModel
}