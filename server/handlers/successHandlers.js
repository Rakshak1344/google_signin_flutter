ok200 = (objectData) => {
    return { "status": 200, "success": "true", "data": objectData }
}
ok201 = (objectData) => {
    return { "status": 201, "success": "true", "data": objectData }
}

ok201UserWithToken = (user, token) => {
    return { "status": 201, "success": true, "data": user, token }
}

module.exports = {
    ok200,
    ok201,
    ok201UserWithToken
}