import {getTokenUser} from "~/utils/functions/tokenUser";

const authMiddleware = async () => {
    const token = getTokenUser()

    if (!token) {
        return navigateTo('/signin');
    }
}

export default authMiddleware;