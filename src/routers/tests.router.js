const express = require('express')
const { getTests } = require('../controllers/tests.controller')

const router = express.Router()

router.get('/tests', getTests)

module.exports = router