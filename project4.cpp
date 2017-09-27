#include <stdlib.h>
#include <getopt.h>
#include <stdio.h>

#include <iostream>
#include <sstream>
#include <fstream>
#include "string.h"
#include <vector>
#include <deque>
#include <algorithm>
#include <sstream>
#include <queue>
#include <math.h>
#include <iomanip>
#include <deque>
#include <numeric>
using namespace std;

class Point{
    public:
    Point(int x_in, int y_in): x_coord(x_in), y_coord(y_in){
        if (x_coord < 0 && y_coord < 0){
            cage_Type = 'w';
         
        }
        else if((x_coord == 0 && y_coord <= 0) || (y_coord == 0 && x_coord <= 0) ){
            cage_Type = 'b';
         
        }
        else{
            cage_Type = 's';
        }
     
    }  

    int x_coord;
    int y_coord;
    char cage_Type;
 };

class MST{
public:
    MST(){
        distance = INFINITY;
        visited = false;
    }

    double distance;
    bool visited;
    unsigned parent;
  
};


struct calculate_Distance{
    const vector<Point> &input;

 public:
    calculate_Distance(const vector<Point> &edges_in): input(edges_in){}
     
    double operator()(unsigned i, unsigned j) const{
        if ((input[i].cage_Type ==  's' && input[j].cage_Type == 'w') || (input[i].cage_Type ==  'w' && input[j].cage_Type == 's') ){
            return INFINITY;
        }
        else{
            double x = double(input[j].x_coord - input[i].x_coord);
            double y = double(input[j].y_coord - input[i].y_coord);
            return sqrt(y*y + x*x); 
        }
     }
 };
 struct calculate_Distance2{
    const vector<Point> &input;

 public:
    calculate_Distance2(const vector<Point> &edges_in): input(edges_in){}
     
    double operator()(unsigned i, unsigned j) const{
        double x = double(input[j].x_coord - input[i].x_coord);
        double y = double(input[j].y_coord - input[i].y_coord);
        return sqrt(y*y + x*x); 
    
    }
 };
struct calculate_Distance3{
    const vector<Point> &input;
    vector<vector<double>> A;
 public:
    calculate_Distance3(const vector<Point> &edges_in): input(edges_in), A(input.size(), vector<double>(input.size(),0)){
        for(unsigned i = 0; i < A.size(); ++i){
            for(unsigned j = 0; j < A.size(); ++j){
                double x = double(input[j].x_coord - input[i].x_coord);
                double y = double(input[j].y_coord - input[i].y_coord);
                A[i][j] = sqrt(x*x + y*y);
            }
        } 
    }
     
    double operator()(unsigned i, unsigned j) const{
        return A[i][j]; 
    }
 };

template<typename T>
void prims(vector<MST> &edges, T &dist);
template <typename T>
void FASTTSP(vector<Point> &input, T dist, vector<int> &path);
template <typename T>
bool promising(deque<int> &unvisited, vector<int> &current_Path, T &dist, double &upper_Bound, double current_Dist);
template <typename T>
void genPerms(deque<int> &unvisited, T &dist, vector<int> &current_Path, double &upper_Bound, double &current_Dist, vector<int> &path);

template <typename T>
void OPTTSP(vector<Point> &input, deque<int> &unvisited, T &dist, vector<int> &current_Path, vector<int> &path, double &upper_Bound);

int main(int argc, char **argv) {
    // Your code goes here...
    cout << std::setprecision(2);
    cout << std::fixed;
    //freopen("sample-c.txt", "r", stdin);
    int var;
    bool set_Mode = false;
    bool set_MST = false;
    bool set_OPTTSP = false;
    bool set_FASTTSP = false;
    
    while(1){
        
        static struct option long_options[] =
        {
            {"mode", required_argument, 0, 'm'},
            {"help", no_argument, 0, 'h'},
            {0, 0, 0, 0}
        };
        
        int index = 0;
        
        var = getopt_long(argc, argv, "m:h", long_options, &index);
        if (var == -1)
            break;
        switch (var){
                
            case 'm':
                if (set_Mode){
                    cerr << "You have already set the mode type";
                    exit(1);
                }
                else {
                    if (strcmp(optarg, "MST\0") == 0){
                        set_MST = true;
                        set_Mode = true;
                    }
                    else if (strcmp(optarg, "OPTTSP\0") == 0){
                        set_OPTTSP = true;
                        set_Mode= true;
                    }
                    else if (strcmp(optarg, "FASTTSP\0") == 0){
                        set_FASTTSP = true;
                        
                        set_Mode = true;
                    }
                    else{
                        cerr << "You must specify a mode type";
                        exit(1);
                    }
#ifdef DEBUG
                    cout << "mode option specified" <<'\n';
                    cout << "Argument for 'm': "<< optarg << '\n';
#endif
                }
                break;
            case 'h':
                cout << "proj4 is a program .....";
                exit(0);
                break;
                
        }
        
    }
    vector<Point> input;
    int num_Cages = 0;
    cin >> num_Cages;
    //check if its 0 cages
    input.reserve(num_Cages);
    int x = 0;
    int y = 0;
    while(cin >> x >> y){
            
        input.emplace_back(x, y);
            
    }
   
    
    if(set_MST){
        vector<MST> edges(input.size());
        double total_Dist = 0;
        calculate_Distance calc(input);
        prims(edges, calc);
       
        for(size_t i = 1; i < edges.size(); ++i){
            total_Dist = total_Dist + edges[i].distance;
        }
        cout << total_Dist << endl;
        for(size_t i = 1; i < edges.size(); ++i){
            if (i < edges[i].parent){
                cout << i << " " << edges[i].parent << endl;
            }
            else{
                cout << edges[i].parent << " " << i << endl;
            }  
        }  
    }
    
    if (set_FASTTSP){
    
        calculate_Distance2 dist(input);
        vector<int> path;
      
        
        path.push_back(0);
        path.push_back(1);
        path.push_back(0);  
    
        FASTTSP(input,dist, path);
       
        double weight = 0;
        double new_Dist = 0;
        
        for(unsigned i = 1; i < path.size(); ++i){
            new_Dist = dist(path[i-1], path[i]);

            weight = weight + new_Dist;
        }
        cout << weight << endl;
        for(size_t i = 0; i < path.size()-1; ++i){
            cout << path[i] << " ";
        }
        

    }
    if (set_OPTTSP){
        deque<int> unvisited(input.size());
        vector<int> current_Path;
        vector<int> path;
        iota(unvisited.begin(), unvisited.end(), 0);
        calculate_Distance3 dist(input);
        double upper_Bound;
        
        OPTTSP(input, unvisited, dist, current_Path, path, upper_Bound);
      
        cout << upper_Bound << endl;
      
        for(size_t i = 0; i < path.size(); ++i){
            cout << path[i] << " ";
        }
        //cout << path.back() << endl;
    }

    return 0;
    
}

template <typename T>

void prims(vector<MST> &edges, T &dist){
  
    MST current = edges.front();
    unsigned min_Index = 0;
    double min_Dist;
    double next = -1;
    unsigned count = 1;
    double current_Dist = -1;
    double prev_Dist = -1;
    
    edges[0].distance = 0;
   
    while(count != edges.size()){

        min_Dist = INFINITY;
        for(unsigned i = 0; i < edges.size(); ++i){
            if (edges[i].visited == false){
              
                next = edges[i].distance;
                if (min_Dist > next){
                    min_Dist = next;
                    min_Index = i;
                }
            }
            
        }
        edges[min_Index].visited = true;
        ++count;
        for(unsigned i = 0; i < edges.size(); ++i){
            if (edges[i].visited == false){
                prev_Dist = edges[i].distance;
                current_Dist = dist(min_Index, i);
                
                if(current_Dist < prev_Dist){
                   
                    edges[i].distance = current_Dist;
                    edges[i].parent = min_Index;
        
                }
            }
 
        }
        current = edges[min_Index];
    }
}

template <typename T>
void FASTTSP(vector<Point> &input, T dist, vector<int> &path){
    double triangle_Dist = 0;
    unsigned min_Index = -1;
    for(unsigned i = 2; i < input.size(); i++){// already initialized to input.size
        double triangle_Dist_min = INFINITY;
        for(unsigned j = 0; j < path.size()-1; j++){
            triangle_Dist = dist(path[j],i) + dist(i, path[j+1]) - dist(path[j], path[j+1]);
            if(triangle_Dist < triangle_Dist_min){
                triangle_Dist_min = triangle_Dist;
                min_Index = j;
            }
        }
        path.insert(path.begin()+ min_Index + 1, i);
    }
}

template <typename T>
bool promising(deque<int> &unvisited, vector<int> &current_Path, T &dist, double &upper_Bound, double current_Dist){
    double total_Dist = current_Dist;
    double first_Dist = 0;
    double last_Dist = 0;
    double first_MAX = INFINITY;
    double last_MAX = INFINITY;

    if(current_Path.size() == 1){
        return true;
    }
    vector<MST> unvisited2(unvisited.size());
    vector<Point> input2;
    input2.reserve(unvisited.size());

    for(unsigned i = 0; i < unvisited.size(); ++i){
        input2.push_back(dist.input[unvisited[i]]);
        //cout << "COORDS " << dist.input[unvisited[i]].x_coord << " " << dist.input[unvisited[i]].y_coord << endl;
    }
    calculate_Distance3 dist2(input2);
    prims(unvisited2, dist2);
    
    for(size_t i = 1; i < unvisited2.size(); ++i){
        total_Dist = total_Dist + unvisited2[i].distance;
        //cout << "total_Dist " << total_Dist << endl;
        //cout << "unvisited2 dist " << unvisited2[i].distance << endl;
    }
    //cout << "total_Dist " << total_Dist << endl;
    
    for(unsigned i = 0; i < unvisited.size(); ++i){
        first_Dist = dist(current_Path.front(), unvisited[i]);
        if(first_Dist < first_MAX){
            first_MAX = first_Dist;
        }
        last_Dist = dist(current_Path.back(), unvisited[i]);
        if(last_Dist < last_MAX){
            last_MAX = last_Dist;
        }
    }
  
    total_Dist = total_Dist + first_MAX + last_MAX;
    if(total_Dist < upper_Bound){
        return true;
    }
    else{
        return false;
    }
}
template <typename T>
void genPerms(deque<int> &unvisited, T &dist, vector<int> &current_Path, double &upper_Bound, double &current_Dist, vector<int> &path){
    //cout << "unvisited size " << unvisited.size() << endl;
    if(unvisited.empty()){
        //cout << " HELLO " << endl;
        if(current_Dist + dist(current_Path.back(), current_Path.front()) < upper_Bound){
            upper_Bound = current_Dist + dist(current_Path.back(), current_Path.front());
            path = current_Path; //output path weight
       
        }

        return;
    }
    if(!promising(unvisited, current_Path, dist, upper_Bound, current_Dist)){
        return;
    }
    for(unsigned k = 0; k != unvisited.size(); k++){
     
        current_Dist = current_Dist + dist(current_Path.back(), unvisited.front());
        current_Path.push_back(unvisited.front());
        //cout << " unvisited front " << unvisited.front() << endl;
        unvisited.pop_front();
        genPerms(unvisited, dist, current_Path, upper_Bound, current_Dist, path);
        unvisited.push_back(current_Path.back());
        current_Path.pop_back();
        current_Dist = current_Dist - dist(current_Path.back(), unvisited.back());
        
    }
}
template <typename T>
void OPTTSP(vector<Point> &input, deque<int> &unvisited, T &dist, vector<int> &current_Path, vector<int> &path, double &upper_Bound){
    double current_Dist = 0;
    
    double new_Dist = 0;
    vector<int> fast_Path;
    fast_Path.push_back(0);
    fast_Path.push_back(1);
    fast_Path.push_back(0); 
    FASTTSP(input, dist, fast_Path); // make another random vector
    path = fast_Path;


    for(unsigned i = 1; i < fast_Path.size(); ++i){
        new_Dist = dist(fast_Path[i-1], fast_Path[i]);
        upper_Bound = upper_Bound + new_Dist;
    }
    current_Path.push_back(0);
    unvisited.pop_front();
 
    genPerms(unvisited, dist, current_Path, upper_Bound, current_Dist, path);     
    if(path == fast_Path){
        path.pop_back();
    }

}

