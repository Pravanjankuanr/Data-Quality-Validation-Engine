import csv, random
from datetime import date,timedelta
from pathlib import Path
random.seed(20261017)
out=Path(__file__).resolve().parent
states=['Telangana','Maharashtra','Karnataka','Odisha','Delhi','Tamil Nadu','West Bengal','Gujarat']
first=['Amit','Neha','Rahul','Priya','Ravi','Ananya','Sanjay','Pooja','Arjun','Meera','Kiran','Sonia']
last=['Sharma','Kumar','Rao','Patel','Das','Singh','Reddy','Kuanr','Nair','Gupta']
def dt(start,days):return (start+timedelta(days=random.randrange(days))).isoformat()
with (out/'customers.csv').open('w',newline='',encoding='utf-8') as f:
 w=csv.writer(f);w.writerow(['row_id','customer_id','customer_name','email','mobile','state','date_of_birth','created_at'])
 for i in range(1,10001):
  cid=f'C{i:06d}' if i%47 else f'C{i-1:06d}'
  name=f'{random.choice(first)} {random.choice(last)}'
  if i%29==0:name=' '+name.lower()+' '
  email=f'{name.strip().lower().replace(" ",".")}{i}@example.com'
  if i%31==0:email=''
  if i%83==0:email='invalid-email'
  mobile='9'+''.join(str(random.randrange(10)) for _ in range(9))
  if i%37==0:mobile=mobile[:8]
  if i%101==0:mobile=''
  state=random.choice(states)
  if i%41==0:state=state.lower()
  if i%67==0:state=''
  dob=dt(date(1960,1,1),16000)
  if i%113==0:dob='2035-01-01'
  w.writerow([i,cid,name,email,mobile,state,dob,dt(date(2023,1,1),1250)])
with (out/'policies.csv').open('w',newline='',encoding='utf-8') as f:
 w=csv.writer(f);w.writerow(['row_id','policy_id','customer_id','product_type','start_date','end_date','premium_amount','policy_status','agent_id'])
 for i in range(1,50001):
  pid=f'P{i:07d}' if i%89 else f'P{i-1:07d}'
  cid=f'C{random.randint(1,10000):06d}'
  if i%151==0:cid='C999999'
  start=date(2023,1,1)+timedelta(days=random.randrange(1100))
  end=start+timedelta(days=random.choice([180,365,730]))
  if i%73==0:end=start-timedelta(days=30)
  premium=round(random.uniform(2500,85000),2)
  if i%97==0:premium=-premium
  if i%131==0:premium=''
  status=random.choice(['ACTIVE','EXPIRED','CANCELLED','PENDING'])
  if i%43==0:status=status.lower()
  agent=f'A{random.randint(1,120):04d}' if i%59 else ''
  w.writerow([i,pid,cid,random.choice(['TERM','HEALTH','SAVINGS','ULIP']),start,end,premium,status,agent])
with (out/'payments.csv').open('w',newline='',encoding='utf-8') as f:
 w=csv.writer(f);w.writerow(['row_id','payment_id','policy_id','payment_date','payment_amount','payment_status','payment_method'])
 for i in range(1,100001):
  payid=f'T{i:08d}' if i%103 else f'T{i-1:08d}'
  pid=f'P{random.randint(1,50000):07d}'
  if i%173==0:pid='P9999999'
  amount=round(random.uniform(200,50000),2)
  if i%107==0:amount=-amount
  if i%139==0:amount=''
  status=random.choice(['SUCCESS','FAILED','PENDING','REFUNDED'])
  if i%47==0:status=status.lower()
  w.writerow([i,payid,pid,dt(date(2023,1,1),1350),amount,status,random.choice(['UPI','CARD','NEFT','CASH'])])
print('Created customers.csv, policies.csv, payments.csv')
