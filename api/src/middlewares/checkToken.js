import {verify} from "../services/JWTService.js";

export default (req, res, next) => {
    const headers = req.headers
    const auth = headers["Authorization"]
    const b64 = auth.split(" ")[1]
    const token = atob(b64)

    verify(token, (err, decoded) => {
        if(err){
            res.status(401)
            res.json({error: "Token invalide"})
        } else {
            req.id = decoded.id
            next()
        }
    })
};
