const { Router } = require('express')
const router = Router()

const User = require('../models/userModel')
const Caja = require('../models/cajaModel')

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
<<<<<<< HEAD
        user.password = await user.encryptPassword(password);
        await user.save();
=======
        const caja= new Caja({
            email,
            P:0,
            V:0,
            L:0
        });
        user.password = await user.encryptPassword(password);
        await user.save();
        await caja.save();
       
>>>>>>> develop

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

router.get('/usercaja',async (req,res)=>{
    try{
        caja= await Caja.findOne({email:req.body.email})
            res.status(200).send({type_1:caja.P,type_4:caja.V,type_9:caja.L});

        }catch(e){
        console.log(e)
        res.status(500).send({message:'hubo un problema'})
        }   
    });
router.post('/updatecaja', async(req,res)=>{
<<<<<<< HEAD
=======
    console.log(req.body)
>>>>>>> develop
    try{
        caja= await Caja.findOne({email:req.body.email})
        cantidad_P= caja.P;
        cantidad_V=caja.V;
        cantidad_L=caja.L;
<<<<<<< HEAD
        modi_P=req.body.P;
        modi_V=req.body.V;
        modi_L=req.body.L;
        if(cantidad_P!=null){
            cantidad_P=cantidad_P + modi_P;
        }
        if(cantidad_V!=null){
            cantidad_V =cantidad_V + modi_V;
        }
        if(cantidad_P!=null){
            cantidad_L =cantidad_L + modi_L;
        }

    }
=======
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
>>>>>>> develop


module.exports = router;