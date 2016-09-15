Configuration
========================================

  Patch `web/wsgiserver/__init__.py`

    # See http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/442473
    ctx = SSL.Context(SSL.SSLv23_METHOD)                                
    ctx.use_privatekey_file(self.ssl_private_key)                       
    ctx.use_certificate_file(self.ssl_certificate)                      
								       
    # Chui Tey                                                          
    if self.ssl_certificate_chain:                                      
        ctx.use_certificate_chain_file(self.ssl_certificate_chain)      


Running the tutorial
========================================
    ssh -i ~/.ssh/id_rsa chui@readify-b2b.australiaeast.cloudapp.azure.com
    cd b2b
    sudo python app.py 443


