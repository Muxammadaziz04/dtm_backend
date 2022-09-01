const { getTestsModel, postTestModel, putTestModel, deleteTestModel } = require("../models/tests.model");

const getTests = async (req, res, next) => {
    try {
        const response = await getTestsModel(req.query)

        if (response.error) return next(response)

        res.status(200).send({
            status: 200,
            data: response
        })
    } catch (error) {
        console.log(error);
    }
}

const postTest = async (req, res, next) => {
    try {
        const response = await postTestModel(req.body)

        if (response.error || !response.length) return next(response)

        res.status(201).send({
            status: 201,
            data: response
        })
    } catch (error) {
        console.log(error);
    }
}

const putTest = async (req, res, next) => {
    try {
        const response = await putTestModel(req.body, req.params)

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

const deleteTest = async (req, res, next) => {
    try {
        const response = await deleteTestModel(req.params)

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
    getTests,
    postTest,
    putTest,
    deleteTest
}