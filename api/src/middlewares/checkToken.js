import {decode, verify} from "../services/JWTService.js";

export default (req, res, next) => {
    try{
        const auth = req.get("Authorization")
        const token = auth.split(" ")[1]
        const ver = verify(token)
        if (ver) {
            const decoded = decode(token)
            req.id = decoded.id
            next()
        } else {
            res.status(401)
            res.json({error: "Token invalide"})
        }
    } catch (e) {
        res.status(500)
        res.json({error:  "Token manquant"})
    }

}
