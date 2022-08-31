const express = require('express')
const { getRegions } = require('../controllers/regions.controller')

const router = express.Router()

router.get('/regions', getRegions)

module.exports = router