const Joi = require('joi')

const resultSchema = Joi.object({
    first_subject: Joi.number().integer().required(), 
    second_subject: Joi.number().integer().required(), 
    first_tests_count: Joi.number().integer().required(), 
    second_tests_count: Joi.number().integer().required(),
    time: Joi.number().integer().required(), 
    faculties: Joi.array().items(Joi.string().guid({ version: 'uuidv4' })).required(),
    user_id: Joi.string().guid({ version: 'uuidv4' }).required(),
    first_subject_id: Joi.string().guid({ version: 'uuidv4' }).required(), 
    second_subject_id: Joi.string().guid({ version: 'uuidv4' }).required()
})

const testSchema = Joi.object({
    question: Joi.string().min(10).required(), 
    question_variants: Joi.object().required(), 
    subject_id: Joi.string().guid({ version: 'uuidv4' }).required()
})

const facultySchema = Joi.object({
    faculty_name: Joi.string().min(2).required(), 
    first_subject: Joi.string().guid({ version: 'uuidv4' }).required(), 
    second_subject: Joi.string().guid({ version: 'uuidv4' }).required(), 
    grant_count: Joi.number().integer().required(), 
    contract_count: Joi.number().integer().required(), 
    passing_score_grant: Joi.number().required(), 
    passing_score_contract: Joi.number().required(), 
    university_id: Joi.string().guid({ version: 'uuidv4' }).required()
})

const universitySchema = Joi.object({
    university_name: Joi.string().min(5).required(),
    region_id: Joi.string().guid({ version: 'uuidv4' }).required()
})

const subjectSchema = Joi.object({
    subject_name: Joi.string().min(5).required()
})

module.exports = {
    resultSchema,
    testSchema,
    facultySchema,
    universitySchema,
    subjectSchema
}