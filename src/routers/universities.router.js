const express = require('express')
const { getUniversities } = require('../controllers/universities.controller')

const router = express.Router()

router.get('/universities', getUniversities)

module.exports = router