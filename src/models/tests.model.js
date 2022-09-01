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

const postTestModel = async ({ question, question_variants, subject_id }) => {
    try {
        const postTestQuery = `
        insert into questions(question, question_variants, subject_id)
        values ($1, $2, $3) returning *
        `
        return await fetchData(postTestQuery, question, question_variants, subject_id)
    } catch (error) {
        console.log(error);
    }
}

const putTestModel = async (body, { question_id }) => {
    try {
        const getTestQuery = `select * from questions where question_id = $1`
        const [oldTest] = await fetchData(getTestQuery, question_id)

        if (!oldTest) return []

        const { question, question_variants, subject_id } = { ...oldTest, ...body }

        const TestQuery = `
        update questions set 
        question = $2, 
        question_variants = $3, 
        subject_id = $4
        where university_id = $1
        `
        return await fetchData(TestQuery, question_id, question, question_variants, subject_id)
    } catch (error) {
        console.log(error);
    }
}

const deleteTestModel = async ({ question_id }) => {
    try {
        const deletTestQuery = `
        delete from questions where question_id = $1
        `
        return await fetchData(deletTestQuery, question_id)
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    getTestsModel,
    postTestModel,
    putTestModel,
    deleteTestModel
}