const { Router } = require('express')
const router = Router()

const User = require('../models/userModel')
const Caja = require('../models/cajaModel')
const Locations = require('../models/locationsModel')


const verifyToken = require('./verifyToken')

const jwt = require('jsonwebtoken')
const config = require('../config')

router.post('/signup',async(req,res)=>{
    console.log("alguien se registra")
    try{
        const { username,email, password} = req.body;

        const user = new User ({
            username,
            email,
            password
        });
        user.password = await user.encryptPassword(password);
        await user.save();

        const caja= new Caja({
            email,
            P:0,
            V:0,
            L:0
        });
        user.password = await user.encryptPassword(password);
        await user.save();
        await caja.save();
       
        const token = jwt.sign({id: user.id},
            config.secret,{
                expiresIn: '24h'
            });
        console.log('registro exitoso');
        res.status(200).json({auth:true, token})
    }catch(e){
        console.log(e)
        res.status(500).send('hubo un problema')
    }
});

router.post('/signin',async(req,res)=>{
    //console.log(req);
    console.log("llego un post");
    try{
        const user = await User.findOne({email:req.body.email})
        if(!user){
            return res.status(404).send({error:'El email no esta registrado',token:null})
        }

        const validPassword = await user.validatePassword(req.body.password,user.password); 
        if(!validPassword){
            return res.status(401).send({auth:false,token:null});
            
        }
        const token = jwt.sign({id:user._id},config.secret,{
            expiresIn:'24h'
        });
        console.log("autenticacion exitosa")
        res.status(200).json({auth:true,token});
    }catch(e){
        console.log(e)
        res.status(500).send({message:'hubo un problema'})
    }
});

router.get('/logout',function(req,res){
    res.status(200).send({auth:false,token:null})
});

router.post('/userdata',async (req,res)=>{
    try{
        user= await User.findOne({email:req.body.email})
        res.status(200).send({username:user.username,locations:user.locations,usermail:user.email});
        }catch(e){
        console.log(e)
        res.status(500).send({message:'hubo un problema'})
        }   
    });

router.post('/usercaja',async (req,res)=>{
    try{
        caja= await Caja.findOne({email:req.body.email})
            res.status(200).send({P:caja.P,V:caja.V,L:caja.L});

        }catch(e){
        console.log(e)
        res.status(500).send({message:'hubo un problema'})
        }   
    });

router.post('/updatecaja', async(req,res)=>{
    try{
        caja= await Caja.findOne({email:req.body.email})
        cantidad_P= caja.P;
        cantidad_V=caja.V;

        if(req.body.hasOwnProperty("P")){
            cantidad_P=cantidad_P + req.body.P;
        }
        if(req.body.hasOwnProperty("V")){
            cantidad_V =cantidad_V + req.body.V;
        }
        if(req.body.hasOwnProperty("L")){
            cantidad_L =cantidad_L + req.body.L;
        }
        data={P:cantidad_P,L:cantidad_L,V:cantidad_V}
        await Caja.findOneAndUpdate(req.body.email,data);
        caja.save();
        res.status(200).send(data)


    }catch(e){
        console.log(e)
        res.status(500).send({message:'hubo un problema'})
        }   
    });

router.post('/updateuser', async(req,res)=>{
    try{
        user= await User.findOne({email:req.body.email})
        user_password=user.password;

        if(req.body.hasOwnProperty("username")){
            if(req.body.username==user.username){
                res.status(500).send({message:'Este usuario ya existe'})
            }
            user_name=req.body.username;
        }
        if(req.body.hasOwnProperty("email")){
            user_mail=req.body.email;
        }
        if(req.body.hasOwnProperty("password")){
            user_password=user.password;
        }
        if(req.body.hasOwnProperty("locations")){
            user_locations=req.body.locations;
        }
        data={username:user_name,email:user_mail,password:user_password,locations:user_locations}
        console.log(data)
        await User.findOneAndUpdate(req.body.email,data);
        user.save();
        res.status(200)


    }catch(e){
        console.log(e)
        res.status(500).send({message:'hubo un problema'})
        }   
    });

router.post('/puntosverdes', async(req,res)=>{
try{
    const {types,longitude,latitude} = req.body;
    const locations = new Locations ({
            types,
            longitude,
            latitude
        }); 
        console.log(types)
        await locations.save();
        res.status(200).send()


    }catch(e){
        console.log(e)
        res.status(500).send({message:'hubo un problema'})
        }   
    });

router.post('/rutasverdes', async(req,res)=>{
try{
    locations= await Locations.findOne({types:req.body.types});
    
    console.log(locations)
    res.status(200).send()


    }catch(e){
        console.log(e)
        res.status(500).send({message:'hubo un problema'})
        }   
    });




module.exports = router;