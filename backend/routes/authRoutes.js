router.post("/login", async(req,res)=>{
   const {email,password} = req.body;

   const user = await User.findOne({email});

   if(!user){
      return res.status(404).json("User not found");
   }

   res.json(user);
});