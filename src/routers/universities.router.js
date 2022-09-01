const express = require('express')
const { getUniversities, postUniversity, putUniversity, deleteUniversity } = require('../controllers/universities.controller')

const router = express.Router()

router.get('/universities', getUniversities)
router.post('/university', postUniversity)
router.put('/university/:university_id', putUniversity)
router.delete('/university/:university_id', deleteUniversity)

module.exports = router