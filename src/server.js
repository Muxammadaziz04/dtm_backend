const express = require('express')
const cors = require('cors')

const userRouter = require('./routers/users.router.js')
const subjectsRouter = require('./routers/subjects.router.js')
const universitiesRouter = require('./routers/universities.router.js')
const facultiesRouter = require('./routers/faculties.router.js')
const testsRouter = require('./routers/tests.router.js')
const resultsRouter = require('./routers/results.router.js')

const { PORT } = require('./utils/config')

const app = express()

app.use(express.json())
app.use(cors())

app.use(userRouter)
app.use(subjectsRouter)
app.use(universitiesRouter)
app.use(facultiesRouter)
app.use(testsRouter)
app.use(resultsRouter)

app.use((error, req, res, next) => {
    return res.send({ error: error.error?.message || error.message || 'Somethink went wrong' })
})

app.listen(PORT, () => console.log(`Server is run on ${PORT} port`))