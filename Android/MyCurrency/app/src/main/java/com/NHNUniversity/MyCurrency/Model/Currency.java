package com.NHNUniversity.MyCurrency.Model;

public class Currency {
    private final String[] All_Currency = {"EUR", "USD", "HUF", "AED", "JPY", "GBP", "ARS"};
    private final String[] Name_Currency = {"Euro", "Dollaro Statunitense", "Fiorino ungherese", "Dirham Emirati Arabi", "Yen giapponese", "Sterlina britannica", "Peso argentino"};
    private int index;

    //Builder
    public Currency(){
        this.index = 0;
    }
    public Currency(int index){
        this.index = index;
    }


    //Methods
    public final int get_index(){
        return this.index;
    }
    public final String[] get_actual(){
        final String[] actual = {this.All_Currency[this.index], this.Name_Currency[this.index]};
        return actual;
    }

    public final String[] next(){
        index++;
        if(index == this.All_Currency.length)
            index = 0;

        return get_actual();
    }
    public final String[] previous(){
        index--;
        if(index < 0)
            index = this.All_Currency.length - 1;

        return get_actual();
    }

}
