import jenkins.model.* 
	import hudson.model.* 
	def name = 'pipeline skeleton demo' 
	def v = new ListView(name) 
	Jenkins.instance.addView(v) 
  	v.add(Jenkins.instance.getItemByFullName('UT'))
	v.add(Jenkins.instance.getItemByFullName('FT'))
	v.add(Jenkins.instance.getItemByFullName('deploy-to-test'))
	v.add(Jenkins.instance.getItemByFullName('deploy-to-uat'))
	v.add(Jenkins.instance.getItemByFullName('deploy-to-production'))