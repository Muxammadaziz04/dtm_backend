const express = require('express')
const { getFirstSubject, getSecondSubject, postSubject, putSubject, deleteSubject } = require('../controllers/subjects.controller')

const router = express.Router()

router.get('/firstsubject', getFirstSubject)
router.get('/secondsubject/:first_subject_id', getSecondSubject)
router.post('/subject', postSubject)
router.put('/subject/:subject_id', putSubject)
router.delete('/subject/:subject_id', deleteSubject)

module.exports = router