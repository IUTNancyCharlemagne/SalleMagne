import jwt from 'jsonwebtoken';
const secretKey = process.env.SECRET_KEY


export function encode(payload, expiresIn = '1h') {
    return jwt.sign(payload, secretKey, {expiresIn});
}

export function decode(token) {
    try {
        return jwt.verify(token, secretKey);

    } catch (error) {
        // Si le token est invalide, une erreur est levée
        return null;
    }
}

export function verify(token) {
    try {
        jwt.verify(token, secretKey);
        return true;
    } catch (error) {
        // Si le token est invalide, une erreur est levée
        return false;
    }
}
