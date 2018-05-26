import csv

#buffer time for lab test
buffer_time = 5 

#returns the session corresponding to a moodle activity.
# 1 for the first session
# 2 for the second session
# 3 for post test activity
# -1 is erroneous
def get_session( time,event ) :
	a = time.split(" ")
	if(not(a[0] == "3" and a[1] == "Feb,")):
		return -1;
	b = a[2].split(":")
	hour = int(b[0])
	minute = int(b[1])
	if(hour == 9 or (hour == 10 and minute <= buffer_time)):
		return 1;
	elif((hour == 10 and minute >= 15) or (hour == 11 and minute <= 15+buffer_time)):
		return 2;
	#any activity after the test that doesn't involve editing is acceptable	
	elif(hour == 11 and minute >15 and (Purpose[event] == 8 or Purpose[event] == 10 or Purpose[event] == 11) ):
		return 2 ;	
	else:
		return -1;			
				

#to check that no user has activity that spans across 2 sessions
def check_session_consistency(user) :
	session = get_session(user[0]['Time'],user[0]['Event'])
	for subm in user:
		s = get_session(subm['Time'],subm['Event'])
		if(s == 3):
			continue
		if(s != session):
			return False;
	return True;	
                 
Purpose = {'mod_vpl: submission debugged':0,
				'mod_vpl: submission deleted':1,
				'mod_vpl: submission edited':2,
				'mod_vpl: submission evaluated':3,
				'mod_vpl: submission grade viewed':4,
				'mod_vpl: submission previous upload viewed':5,
				'mod_vpl: submission run':6,
				'mod_vpl: submission uploaded':7,
				'mod_vpl: submission viewed':8,
				'mod_vpl: vpl all submissions viewed':9,
				'mod_vpl: vpl description viewed':10,
				'mod_vpl: vpl security':11}

users = {}	#dictionary of activities per user
ips = {}	#dictionary of users associated per user

ignore_list = ['Harish Thuwal','Neha Sengupta', 'Jyoti Jyoti', 'Maya Ramanath',
			   'Nitin Rathor', 'Deepak Sharma', 'Shradha Holani', 'Mahima Manik']

reader = csv.DictReader(open('logs.csv','rb'))

for line in reader:
	name = line['User full name']
	if name in ignore_list:
		continue
	else:
		time = line['Time']
		ip = line['IP address']
		affected_user = line['Affected user']
		event = line['Event name'] 
		params1 = {'Time': time,'Affected_user': affected_user,'Event': event,'description':line['Description']}
		params2 = {'Time': time,'Name': name,'Event': event}
		session_id = get_session(time,event)
		if( session_id == -1 ):
			print line	
		if( session_id == 3 ):				#no need to consider post test activity
			continue
		if name in users: 	
			users[name].append(params1)	
		else:
			users[name] = [params1]
	
		p = (name,session_id)	
		if ip in ips:
			if p in ips[ip]:
				continue;
			else:	
				ips[ip].append(p)
		else:
			ips[ip] = [p]		


for name in users:
	user = users[name]
	if(not(check_session_consistency(user))):
		print name
		l = list(map( (lambda x: (x['Time'],x['Event'],x['description'])),user))
		for each in l:
			print each
		print "\n"

print "#Distinct IP addresses used: "+str(len(ips))

count = 0
defaulters  = {}
for ip in ips:
	if(len(ips[ip]) > 1):
		count=count+1;
		print(ips[ip])
		defaulters[ip] = ips[ip]

print "#cases with use of same ip across sessions: "+ str(count)


with open('results.csv', 'wb') as csv_file:
    writer = csv.writer(csv_file)
    for key, value in defaulters.items():
       writer.writerow([key, value])
