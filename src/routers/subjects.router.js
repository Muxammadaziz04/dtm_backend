const express = require('express')
const { getFirstSubject, getSecondSubject } = require('../controllers/subjects.controller')

const router = express.Router()

router.get('/firstsubject', getFirstSubject)
router.get('/secondsubject/:first_subject_id', getSecondSubject)

module.exports = router