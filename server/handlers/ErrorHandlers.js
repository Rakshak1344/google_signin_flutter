err400 = (objectData) => {
    return { "status": 400, "success": "false", "message": objectData }
}

err404 = (objectData) => {
    return { "status": 404, "success": "false", "message": objectData }
}

module.exports = {
    err400,
    err404
}