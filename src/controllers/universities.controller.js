const { getUniversitiesModel, postUniversityModel, putUniversityModel, deleteUniversityModel } = require("../models/universities.model");

const getUniversities = async (req, res, next) => {
    try {
        const response = await getUniversitiesModel(req.query)

        if (response.error) return next(response)

        res.status(200).send({
            status: 200,
            data: response
        })
    } catch (error) {
        console.log(error);
    }
}

const postUniversity = async (req, res, next) => {
    try {
        const response = await postUniversityModel(req.body)

        if (response.error || !response.length) return next(response)

        res.status(201).send({
            status: 201,
            data: response
        })
    } catch (error) {
        console.log(error);
    }
}

const putUniversity = async (req, res, next) => {
    try {
        const response = await putUniversityModel(req.body, req.params)

        if (response.error || !response.length) return next(response)

        res.status(201).send({
            status: 201,
            message: 'successful updated',
            data: response
        })
    } catch (error) {
        console.log(error);
    }
}

const deleteUniversity = async (req, res, next) => {
    try {
        const response = await deleteUniversityModel(req.params)

        if (response.error || !response.length) return next(response)

        res.status(201).send({
            status: 203,
            message: 'successful deleted',
            data: response
        })
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    getUniversities,
    postUniversity,
    putUniversity,
    deleteUniversity
}