const express = require('express')
const { getTests, postTest, putTest, deleteTest } = require('../controllers/tests.controller')

const router = express.Router()

router.get('/tests', getTests)
router.post('/test', postTest)
router.put('/test/:question_id', putTest)
router.delete('/test/:question_id', deleteTest)

module.exports = router