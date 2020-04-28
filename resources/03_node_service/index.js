const express = require('express');

const app = express();

app.get('/ping', (req, res) => res.send('Pong!'));

app.listen(process.env.PORT, () => {
    console.log(`App running on port ${process.env.PORT}`); 
});
