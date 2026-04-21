const db = require("./DB/DB");
const session = require("express-session");
const bcrypt = require("bcrypt");
const cors = require("cors");
const express = require("express");

const app = express();

app.use(express.json());


app.use(cors({
    origin: "http://127.0.0.1:5500",
    credentials: true
}));

app.use(session({
    secret: "secreto",
    resave: false,
    // resave controla si la sesión se guarda en cada petición aunque no haya cambios
    saveUninitialized: false,
    // No guarda sesiones vacías (usuarios no autenticados).
    cookie:{
        secure:false,
        //https
        httpOnly:true,
        sameSite:"lax"
        //samesite controla si la cookie se envía en peticiones entre diferentes sitios.
    }
}));


app.post("/register", async (req, res) => {
    const { name, email, password} = req.body;
    const hash = await bcrypt.hash(password, 10);
    const sql = "INSERT INTO users (name, email, password) VALUES(?,?,?)";
    db.query(sql, [name, email, hash], (err) => {
        if (err){
            return res.status(500).send(err);
        }
        res.send("Usuario creado");
    });
});


// LOGIN 
app.post("/login", (req, res) => {
    const { email, password } = req.body;
    const sql = "SELECT * FROM users WHERE email=?";
    db.query(sql, [email], async (err, results) => {
        if (results.length === 0) {
            return res.status(401).send("Usuario no encontrado");
        }
        const usuario = results[0];
        const match = await bcrypt.compare(password, usuario.password);
        if (match) {
            // Objeto para guardar datos del usuario en la sesión
            // el . session es una propiedad
            req.session.usuario = {
                id: usuario.id,
                name: usuario.name,
                email: usuario.email
            };
            res.send("Login correcto");
        } else {
            res.status(401).send("Contraseña incorrecta");
        }
    });
});

// LOGOUT
app.get("/logout", (req, res) => {
    req.session.destroy();
    res.send("Logout");
});

//  PERFIL
app.get("/perfil", (req, res) => {
    if (!req.session.usuario) {
        return res.status(401).send("No autorizado");
    }
    res.json(req.session.usuario);
});

//  CREATE 
app.post("/inventory", async (req, res) => {
    if (!req.session.usuario) {
        return res.status(401).send("No autorizado");
    }
    const userId = req.session.usuario.id;
    const { weapon, skin, rarity, floatt, price } = req.body;
    
    // Validar que floatt y price no sean negativos
    if (floatt < 0) {
        return res.status(400).send("El Float no puede ser menor a 0");
    }
    if (price < 0) {
        return res.status(400).send("El Precio no puede ser menor a 0");
    }
    
    const sql = "INSERT INTO inventory(id_user, weapon, skin, rarity, floatt, price) VALUES(?,?,?,?,?,?)";
    db.query(sql, [userId, weapon, skin, rarity, floatt, price], (err) => {
        if (err) {
            return res.status(500).send(err);
        }   
        res.send("Artículo creado");
    });
});

//  READ 
app.get("/inventory", (req, res) => {
    if (!req.session.usuario) {
        return res.status(401).send("No autorizado");
    }
    const userId = req.session.usuario.id;
    db.query("SELECT * FROM inventory WHERE id_user=?", [userId], (err, results) => {
        if (err) {
            return res.status(500).send(err);
        }
        res.json(results);
    });
});

//  UPDATE 
app.put("/inventory/:id", (req, res) => {
    if (!req.session.usuario) {
        return res.status(401).send("No autorizado");
    }
    const userId = req.session.usuario.id;
    const { weapon, skin, rarity, floatt, price } = req.body;
    const { id } = req.params;
    
    // Validar que floatt y price no sean negativos
    if (floatt < 0) {
        return res.status(400).send("El Float no puede ser menor a 0");
    }
    if (price < 0) {
        return res.status(400).send("El Precio no puede ser menor a 0");
    }
    
    const sql = "UPDATE inventory SET weapon=?, skin=?, rarity=?, floatt=?, price=? WHERE id=? AND id_user=?";
    db.query(sql, [weapon, skin, rarity, floatt, price, id, userId], (err, result) => {
        if (err) {
            return res.status(500).send(err);
        }
        if (result.affectedRows === 0) {
            return res.status(404).send("No encontrado o sin permiso");
        }
        res.send("Actualizado");
    });
});

//  DELETE
app.delete("/inventory/:id", (req, res) => {
    if (!req.session.usuario) {
        return res.status(401).send("No autorizado");
    }
    const userId = req.session.usuario.id;
    const { id } = req.params;
    db.query("DELETE FROM inventory WHERE id=? AND id_user=?", [id, userId], (err, result) => {
        if (err){
            return res.status(500).send(err);
        }
        if (result.affectedRows === 0) {
            return res.status(404).send("No encontrado o sin permiso");
        }
        res.send("Eliminado");
    });
});

app.listen(3000, () => {
    console.log("Servidor corriendo en http://127.0.0.1:3000");
});