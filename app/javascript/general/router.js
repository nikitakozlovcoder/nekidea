export class Router {
    
    callWhen(it, ...entrys) {
        let currentEntry =  document.body.dataset.entry;
        entrys.forEach(element => {
            if(currentEntry == element)
            {
                it(currentEntry);
            }
                
        });
    }
}

