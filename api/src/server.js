import {httpServer} from "./app.js";

httpServer.listen(process.env.PORT, () => {
    console.log(`🦉 Serveur HTTP prêt sur le port ${process.env.PORT}`);
})