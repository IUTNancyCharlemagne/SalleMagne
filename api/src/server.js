import {httpServer, httpsServer} from "./app.js";

httpServer.listen(process.env.PORT, () => {
    console.log(`🦉 Serveur HTTP prêt sur le port ${process.env.PORT}`);
})

httpsServer.listen(process.env.PORTHTTPS, () => {
    console.log(`🦉 Serveur HTTPS prêt sur le port ${process.env.PORTHTTPS}`);
})
