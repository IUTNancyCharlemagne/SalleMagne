export const getTokenUser = async () => {
    const token = useCookie("token");
    if (!token.value) {
        return null;
    }
    return token.value;
};


