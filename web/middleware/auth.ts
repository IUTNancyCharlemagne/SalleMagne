import {getTokenUser} from "~/utils/functions/tokenUser";

const authMiddleware = async () => {
    const token = getTokenUser()

    if (!token) {
        return navigateTo('/connexion');
    }
}

export default authMiddleware;