const express = require('express')
const { getFaculties, postFaculty, putFaculty, deleteFaculty } = require('../controllers/faculties.controller')

const router = express.Router()

router.get('/faculties/:faculty_id', getFaculties)
router.post('/faculty', postFaculty)
router.put('/faculty/:faculty_id', putFaculty)
router.delete('/faculty/:faculty_id', deleteFaculty)

module.exports = router