import uno
import unohelper

def createInstance( ctx ):
    # TokenCounter uses a new type, importing it at the top of this file
    # leads to a failure during adding the extension to OOo 
    import org.openoffice.comp.addin.sample.python.jsonparse
    return org.openoffice.comp.addin.sample.python.jsonparse.jsonparse( ctx )

# pythonloader looks for a static g_ImplementationHelper variable
g_ImplementationHelper = unohelper.ImplementationHelper()
g_ImplementationHelper.addImplementation( \
	createInstance,"org.openoffice.comp.addin.sample.python.jsonparse",
        ("com.sun.star.sheet.AddIn",),)
