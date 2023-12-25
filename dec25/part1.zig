const std = @import("std");

const MultiDict = std.StringHashMap(std.ArrayList([]u8));

fn Edge(comptime T: type) type {
    return struct {
        to: usize,
        data: T,
        pub fn cmpEdge(context: void, lhs: Edge(T), rhs: Edge(T)) bool {
            _ = context;
            return lhs.to < rhs.to;
        }
    };
}

fn Graph(comptime T: type) type {
    return struct {
        const Self = @This();
        const EdgeT = Edge(T);
        adjacencyList: std.ArrayList(std.ArrayList(Edge(T))),
        allocator: std.mem.Allocator,

        pub fn init(allocator: std.mem.Allocator) Self {
            return Self{
                .adjacencyList = std.ArrayList(std.ArrayList(EdgeT)).init(allocator),
                .allocator = allocator,
            };
        }

        pub fn addNode(self: *Self) !void {
            try self.adjacencyList.append(std.ArrayList(EdgeT).init(self.allocator));
        }

        fn ensureNodes(self: *Self, expectedNumNodes: usize) !void {
            while (self.numNodes() < expectedNumNodes) {
                try self.addNode();
            }
        }

        pub fn addEdge(self: *Self, from: usize, to: usize, data: T) !void {
            try self.ensureNodes(@max(from, to) + 1);
            try self.adjacencyList.items[from].append(EdgeT{ .to = to, .data = data });
            try self.adjacencyList.items[to].append(EdgeT{ .to = from, .data = data });
        }

        pub fn neighbors(self: Self, from: usize) []EdgeT {
            return self.adjacencyList.items[from].items;
        }

        pub fn numNodes(self: Graph(T)) usize {
            return self.adjacencyList.items.len;
        }
    };
}

fn parseLine(line: []const u8, allocator: std.mem.Allocator, hashMap: *MultiDict) !void {
    var tokenizer = std.mem.tokenizeAny(u8, line, ": \n");
    var key = tokenizer.next() orelse return;
    var entry = try hashMap.getOrPut(try allocator.dupe(u8, key));
    entry.value_ptr.* = std.ArrayList([]u8).init(allocator);

    while (tokenizer.next()) |token| {
        try entry.value_ptr.*.append(try allocator.dupe(u8, token));
    }
}

fn readToHashMap(fileName: []const u8, allocator: std.mem.Allocator) !MultiDict {
    var cwd = std.fs.cwd();
    var input = try cwd.openFile(fileName, std.fs.File.OpenFlags{});
    defer input.close();

    var reader = input.reader();
    var lineBuffer = std.BoundedArray(u8, 256){};
    var hashMap = MultiDict.init(allocator);

    while (reader.streamUntilDelimiter(lineBuffer.writer(), '\n', lineBuffer.capacity())) {
        try parseLine(lineBuffer.slice(), allocator, &hashMap);
        try lineBuffer.resize(0);
    } else |err| {
        switch (err) {
            error.EndOfStream => {},
            else => |e| return e,
        }
    }

    return hashMap;
}

fn getOrPutAndAdvance(hashMap: *std.StringHashMap(usize), key: []const u8, index: *usize) !usize {
    var getOrPut = try hashMap.getOrPut(key);
    if (!getOrPut.found_existing) {
        getOrPut.value_ptr.* = index.*;
        index.* += 1;
    }

    return getOrPut.value_ptr.*;
}

fn hashMapToGraph(allocator: std.mem.Allocator, hashMap: MultiDict) !Graph(i64) {
    var graph = Graph(i64).init(allocator);
    var reverseMap = std.hash_map.StringHashMap(usize).init(allocator);
    defer reverseMap.deinit();

    var index: usize = 0;

    var iter = hashMap.iterator();
    while (iter.next()) |entry| {
        var from = try getOrPutAndAdvance(&reverseMap, entry.key_ptr.*, &index);

        for (entry.value_ptr.*.items) |toStr| {
            var to = try getOrPutAndAdvance(&reverseMap, toStr, &index);

            try graph.addEdge(from, to, 1);
        }
    }

    return graph;
}

fn findPath(allocator: std.mem.Allocator, graph: Graph(i64), from: usize, to: usize) !?std.ArrayList(usize) {
    const FromTo = struct { from: usize, to: usize };
    const unvisited = std.math.maxInt(usize);

    var visitedFrom = try allocator.alloc(usize, graph.numNodes());
    defer allocator.free(visitedFrom);
    @memset(visitedFrom, unvisited);

    var visitStack = std.ArrayList(FromTo).init(allocator);
    defer visitStack.deinit();
    try visitStack.append(FromTo{ .from = from, .to = from });

    while (visitStack.popOrNull()) |toVisit| {
        if (visitedFrom[toVisit.to] != unvisited) {
            continue;
        }

        visitedFrom[toVisit.to] = toVisit.from;

        if (toVisit.to == to) {
            break;
        }

        for (graph.neighbors(toVisit.to)) |neighbor| {
            if (visitedFrom[neighbor.to] == unvisited and neighbor.data > 0) {
                try visitStack.append(FromTo{ .from = toVisit.to, .to = neighbor.to });
            }
        }
    }

    if (visitedFrom[to] == unvisited) {
        // No path found
        return null;
    }

    var result = std.ArrayList(usize).init(allocator);
    var curNode = to;
    while (curNode != from) {
        try result.append(curNode);
        curNode = visitedFrom[curNode];
    }

    try result.append(from);

    return result;
}

fn reset(graph: *Graph(i64)) void {
    for (graph.adjacencyList.items) |adjacencies| {
        for (adjacencies.items) |*edge| {
            edge.data = 1;
        }
    }
}

fn augmentPath(graph: *Graph(i64), path: *std.ArrayList(usize)) void {
    var last = path.pop();

    while (path.popOrNull()) |next| {
        for (graph.*.neighbors(last)) |*edge| {
            if (edge.to == next) {
                edge.data -= 1;
                break;
            }
        }
        for (graph.*.neighbors(next)) |*edge| {
            if (edge.to == last) {
                edge.data = 1;
                break;
            }
        }
        last = next;
    }
}

fn findMinCut(graph: *Graph(i64), allocator: std.mem.Allocator, maxCutAllowed: usize, to: usize) !bool {
    var cutFound: usize = 0;

    while (cutFound <= maxCutAllowed) {
        var path = try findPath(allocator, graph.*, 0, to) orelse return true;
        augmentPath(graph, &path);

        cutFound += 1;
    }

    return false;
}

fn countComponent(graph: Graph(i64), allocator: std.mem.Allocator, from: usize) !usize {
    var visited = try allocator.alloc(bool, graph.numNodes());
    defer allocator.free(visited);
    @memset(visited, false);

    var visitStack = std.ArrayList(usize).init(allocator);
    defer visitStack.deinit();
    try visitStack.append(from);

    var compSize: usize = 0;

    while (visitStack.popOrNull()) |next| {
        if (visited[next]) {
            continue;
        }
        visited[next] = true;
        compSize += 1;

        for (graph.neighbors(next)) |value| {
            if (value.data > 0) {
                try visitStack.append(value.to);
            }
        }
    }

    return compSize;
}

fn calcSolution(graph: *Graph(i64), allocator: std.mem.Allocator, maxCutAllowed: usize) !usize {
    var target: usize = 1;

    while (target < graph.*.numNodes() and !try findMinCut(graph, allocator, maxCutAllowed, target)) {
        reset(graph);
        target += 1;
    }

    return countComponent(graph.*, allocator, 0);
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();
    var hashMap = try readToHashMap("input.txt", allocator);
    var graph = try hashMapToGraph(allocator, hashMap);
    var componentSize = try calcSolution(&graph, allocator, 3);
    var result = componentSize * (graph.numNodes() - componentSize);

    try std.io.getStdOut().writer().print("{d}\n", .{result});
}
