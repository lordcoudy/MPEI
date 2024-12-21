# %%
n1 = 3
mu1 = 1
mu3 = 5
n2 = 6
mu2 = 2
mu3 = 5
E = 0.06
gamma1 = (n1-1)/n1
gamma2 = (n2-1)/n2
gamma3 = (n1+n2-1)/(n1+n2)

lam1 = min(mu1,mu2,mu3/2)
lam2 = lam1
k1 = lam1/(2*n1)
k2 = lam2/(2*n2)
for i in range(2):
    if(i==1):
        print("---------Second iteration----------",end='\n')
        k1 = min(mu1,mu2,mu3/2)/(2*n1)
        k2 = min(mu1,mu2,mu3/2)/(2*n2)
        print(k1,k2,end="\n")
    lam1 = n1*k1
    F1 = n1 - lam1/(mu1-gamma1*lam1) - lam1/(mu3-gamma3*(lam1+lam2))
    l = 1
    print(f"{l}) F1={n1}-{lam1}/({mu1}-{gamma1}*{lam1})-{lam1}/({mu3}-{gamma3}*({lam1}+{lam2}))={F1}\n")
    while True:
        l+=1
        j = 0
        prevF = F1
        prev = lam1
        lam1 = lam1 + F1*k1
        print(f"{l}) lam1 = {prev}+{F1}*{k1}={lam1}\n")
        F1 = n1 - lam1/(mu1-gamma1*lam1) - lam1/(mu3-gamma3*(lam1+lam2))
        print(f"F1={n1}-{lam1}/({mu1}-{gamma1}*{lam1})-{lam1}/({mu3}-{gamma3}*({lam1}+{lam2}))={F1}\n")
        if(F1>=0):
            k = abs(lam1-prev)/lam1
            print(f"|{lam1}-{prev}|/{lam1}={k}\n")
        j = j + 1
        if((j == 100000) or (k<E and F1>=0)):
            #print("Iterative process finished...")
            break
        if(F1<0):
            lam1 = prev
            F1 = prevF
            pvk = k1
            k1 = k1/2
            print(f"k1={pvk}/2={k1}\n")
    l+=1
    lam2= n2*k2
    F2 = n2 - lam2/(mu2-gamma2*lam2) - lam2/(mu3-gamma3*(lam1+lam2))
    print(f"{l}) F2={n2}-{lam2}/({mu2}-{gamma2}*{lam2})-{lam2}/({mu3}-{gamma3}*({lam1}+{lam2}))={F2}\n")
    while True:
        j = 0
        l+=1
        prevF = F2
        prev = lam2
        lam2 = lam2 + F2*k2
        print(f"{l}) lam2 = {prev}+{F2}*{k2}={lam2}\n")
        F2 = n2 - lam2/(mu2-gamma2*lam2) - lam2/(mu3-gamma3*(lam1+lam2))
        print(f"F2={n2}-{lam2}/({mu2}-{gamma2}*{lam2})-{lam2}/({mu3}-{gamma3}*({lam1}+{lam2}))={F2}\n")
        if(F2>=0):
            k = abs(lam2-prev)/lam2
            print(f"|{lam2}-{prev}|/{lam2}={k}\n")
        j = j + 1
        if((j == 100000) or (k<E and F2>=0)):
            #print("Iterative process finished...")
            break
        if(F2<0):
            lam2 = prev
            F2 = prevF
            pvk = k2
            k2 = k2/2
            print(f"k2={pvk}/2={k2}\n")
