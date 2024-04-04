import {getTokenUser} from "~/utils/functions/tokenUser";

const authMiddleware = async (to, from) => {
    const token = getTokenUser()

    if (!token) {
        return navigateTo('/signin');
    }
}

export default authMiddleware;