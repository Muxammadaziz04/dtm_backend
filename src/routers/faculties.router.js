const express = require('express')
const { getFaculties } = require('../controllers/faculties.controller')

const router = express.Router()

router.get('/faculties/:faculty_id', getFaculties)

module.exports = router