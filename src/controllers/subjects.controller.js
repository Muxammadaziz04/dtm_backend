const { getFirstSubjectModel, getSecondSubjectModel, postSubjectModel, putSubjectModel, deleteSubjectModel } = require("../models/subjects.model");

const getFirstSubject = async (req, res, next) => {
    try {
        const response = await getFirstSubjectModel()

        if (response.error) return next(response)

        res.status(200).send({
            status: 200,
            data: response
        })
    } catch (error) {
        console.log(error);
    }
}

const getSecondSubject = async (req, res, next) => {
    try {
        const response = await getSecondSubjectModel(req.params)

        if (response.error) return next(response)

        res.status(200).send({
            status: 200,
            data: response
        })
    } catch (error) {
        console.log(error);
    }
}

const postSubject = async (req, res, next) => {
    try {
        const response = await postSubjectModel(req.body)

        if (response.error || !response.length) return next(response)

        res.status(201).send({
            status: 201,
            data: response
        })
    } catch (error) {
        console.log(error);
    }
}

const putSubject = async (req, res, next) => {
    try {
        const response = await putSubjectModel(req.body, req.params)

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

const deleteSubject = async (req, res, next) => {
    try {
        const response = await deleteSubjectModel(req.params)

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
    getFirstSubject,
    getSecondSubject,
    postSubject,
    putSubject,
    deleteSubject
}