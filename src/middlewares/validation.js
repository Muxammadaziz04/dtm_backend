const { testSchema, facultySchema, resultSchema, subjectSchema, universitySchema } = require("../Joi")


const JoiValidate = (schema, obj, next) =>{
    try {
        const {error} = schema.validate(obj)
        if(error) throw new Error(error.message)
        next()
    } catch (error) {
        next(error)
    }
}

const validation = (req, res, next) => {
    try {
        const [_, route] = req.url.split('/') 

        if(req.method === 'POST'){
            switch (route) {
                case 'test': JoiValidate(testSchema, req.body, next); break;
                case 'faculty': JoiValidate(facultySchema, req.body, next); break;
                case 'result': JoiValidate(resultSchema, req.body, next); break;
                case 'subject': JoiValidate(subjectSchema, req.body, next); break;
                case 'university': JoiValidate(universitySchema, req.body, next); break;
                default: next(); break;
            }
        } else {
            next()
        }
    } catch (error) {
        next(error)
    }
}

module.exports = validation