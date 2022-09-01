const { getFacultiesModel, postFacultyModel, putFacultyModel, deleteFacultyModel } = require("../models/faculties.model");

const getFaculties = async (req, res, next) => {
    try {
        const response = await getFacultiesModel(req.params)

        if (response.error) return next(response)

        res.status(200).send({
            status: 200,
            data: response
        })
    } catch (error) {
        console.log(error);
    }
}

const postFaculty = async (req, res, next) => {
    try {
        const response = await postFacultyModel(req.body)

        if (response.error || !response.length) return next(response)

        res.status(201).send({
            status: 201,
            data: response
        })
    } catch (error) {
        console.log(error);
    }
}

const putFaculty = async (req, res, next) => {
    try {
        const response = await putFacultyModel(req.body, req.params)

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

const deleteFaculty = async (req, res, next) => {
    try {
        const response = await deleteFacultyModel(req.params)

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
    getFaculties,
    postFaculty,
    putFaculty,
    deleteFaculty
}