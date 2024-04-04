
export const getTokenUser = () => {
    const token = useCookie("token");
    if (!token.value) {
        return null;
    }
    return token.value;
};

export const delTokenUser = () => {
    const token = useCookie("token");
    token.value = null;
}


