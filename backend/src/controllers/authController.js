const { Router } = require('express')
const router = Router()

const User = require('../models/userModel')
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

module.exports = router;