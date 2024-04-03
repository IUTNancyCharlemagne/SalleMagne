export function validateEmail(email) {
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!regex.test(email)) {
        return false;
    }

    const regexInjection = /[;<>'"]/;
    return !regexInjection.test(email);
}

export function sanitizeName(name) {
    // Supprime les caractères spéciaux et les balises HTML
    return name.replace(/[^\w\s]/gi, '');
}
